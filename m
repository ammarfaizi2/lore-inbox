Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156973AbPJLL3G>; Tue, 12 Oct 1999 07:29:06 -0400
Received: by vger.rutgers.edu id <S156864AbPJLL27>; Tue, 12 Oct 1999 07:28:59 -0400
Received: from eric.huygens.org ([130.89.181.123]:2311 "EHLO eric.huygens.org") by vger.rutgers.edu with ESMTP id <S156942AbPJLL2O>; Tue, 12 Oct 1999 07:28:14 -0400
Message-Id: <199910121125.NAA14116@eric.huygens.org>
To: linux-kernel@vger.rutgers.edu
Subject: Clockwise - a real-time file system for Linux
From: Peter Bosch <Peter.Bosch@huygens.org>
X-Organisation: U. 20, Dept of CS, Box 217, 7500 AE Enschede, Netherlands
X-Bicycle: A grey one;
X-Bicycle-Usage: To annoy automobile owners.
X-Stupidest-Thing-I-Have-Ever-Done: Visiting Eurodisney.
X-Face: $i'ry3lL\\kg!DtLWtT/u>`=\{0hC@)m7sgTK!QuCm1D00AQ@uG~)euH?:Lq*{;z}]*=+JY @WikXrViRn=!BInIfh?dKsr"'Y2/m>L0:%zP'13gWD.1R_GVns#%1=M>*l`<J'L\+%MQu0O^'3Z-J% h<sx:0`(#=BDNPI4,Ec.{d_AZ,CNG}$B":<l-FB#K=l$(Aw^j0&y|T[*3(H4v!s[k40M*\uI4)WhH/ t-\JY\Wy!45G}&fU(6gh\p&c*FKrIQO`u/B-_MH<BI\&{)&>XKBS5bi|u@6d#T-,sN\+2|@GI$XY/T mU/rHutd7O\`
Date: Tue, 12 Oct 1999 13:25:56 +0200
Sender: owner-linux-kernel@vger.rutgers.edu

Clockwise is a real-time file system for Linux.  Clockwise schedules
data streams from and to disk by means of a non-preemptive EDF scheduler.
Best-effort file systems (e.g. EXT2 file systems) can co-exist on the
disks, and best-effort file systems are served as quickly as is possible 
without endangering real-time deadlines.

More information (and kernel module sources) can be found on:

        http://www.huygens.org/~peterb/clockwise.html

Peter Bosch,
peterb@huygens.org


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
