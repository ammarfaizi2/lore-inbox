Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSKIWo0>; Sat, 9 Nov 2002 17:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSKIWo0>; Sat, 9 Nov 2002 17:44:26 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:60618 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S262800AbSKIWoY>; Sat, 9 Nov 2002 17:44:24 -0500
Message-ID: <3DCD9107.3020103@torque.net>
Date: Sun, 10 Nov 2002 09:49:43 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org,
       Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
Subject: Re: [RFC] Clean up scsi documentation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eike Beer <eike@bilbo.math.uni-mannheim.de> wrote:
 > currently the documentation for scsi is not completely located
 > where it should IMHO be: in Documentation/
 >
 > There are a few files in Documentation and much more files in
 > drivers/scsi/ .
 > I think this should be fixed. Any thougts?
 >
 > My way would be:
 >
 > 1) create a directory Documentation/scsi/
 > 2) move everything to this location
 > 3) rename some of the docs (currently the names look
 > like "README.drivername"
 > but "drivername.txt" is more common in Documentation/*)
 > 4) fix up the references
 > 5) add a 00-INDEX file to Documentation/scsi
<snip/>

Yes, this would be a positive step and has been proposed by
others on the linux-scsi list. It may be a bit late for the
2.4 series but the time would be right for the 2.5 series.

James Bottomley <James.Bottomley@steeleye.com> and Doug Ledford
<dledford@redhat.com> are maintaining BK repositories for the
scsi subsystem in the 2.5 series. If you could submit your
patches to them, then they will find their way to Linus
in an orderly fashion.

Doug Gilbert


