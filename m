Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbTBSGuB>; Wed, 19 Feb 2003 01:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268139AbTBSGuB>; Wed, 19 Feb 2003 01:50:01 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12460 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268133AbTBSGuA>; Wed, 19 Feb 2003 01:50:00 -0500
Date: Tue, 18 Feb 2003 23:00:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 379] New: VIA 8235 rear channel playback on front channels?
Message-ID: <13480000.1045638000@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=379

           Summary: VIA 8235 rear channel playback on front channels?
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: ricko73@yahoo.com


Distribution:  Slackware 8.1
Hardware Environment:  EPIA-M 9000
Software Environment:  VIA 8235 ALSA kernel drivers
Problem Description:  During DVD playback on Mplayer, (using ALSA sound), sound
only comes out of the main two channels (front left and right), but that sound
is supposed to be in the REAR two channels.

Steps to reproduce:  I switched back to 2.5.61 with the same items build into
the kernel.  Sound was as normal for 2 channel support. (front left and right).
 Booted back to 2.5.62 and repeated the same problem.


