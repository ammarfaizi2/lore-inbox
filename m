Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbRGMI7q>; Fri, 13 Jul 2001 04:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbRGMI7g>; Fri, 13 Jul 2001 04:59:36 -0400
Received: from cmbi1.cmbi.kun.nl ([131.174.88.30]:749 "EHLO cmbi1.cmbi.kun.nl")
	by vger.kernel.org with ESMTP id <S266983AbRGMI7X>;
	Fri, 13 Jul 2001 04:59:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dr E B Bettler <bettler@cmbi.kun.nl>
Reply-To: E.bettler@cmbi.kun.nl
Organization: CMBI
To: linux-kernel@vger.kernel.org
Subject: problem with ls, auto-completion functions on mounted disk with 2.4.x kernels
Date: Fri, 13 Jul 2001 10:59:06 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01071310590604.08992@cmbipc37>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
is anybody know a problem with the ls, auto-completion... commands and a SGI 
partition mounted on LInux 2.4.x kernel ?

in our lab', home directories are mounted from SGI to redhat 7.0 pc.
if i make a 'ls -al' of a directory, i have the list of all files in this 
directory.. but if i make a ls *, some files (or directories) are missing. 
This problem is only with 2.4.x kernels. We have compiled 2.4.3, 2.4.5 and 
2.4.6 kernel with the same problem. When we reboot the same machine
on 2.2.16 (or 2.2.19) kernel, problem is gone. This problem is retrieve on 
redhat 7.0 (with 2.4.x kernel), redhat 7.2 (2.4.2 kernel) and Mandrake 8 
(2.4.3 kernel).
We retrieve this problem with gnome softwares but not with KDE softwares ! 
(no relation with the windows manager).
If we make a copy of a problematic directory in another directory on the 
mounted disk (or on the local HD) problem is gone. We don't have 
problems on the local disk.

any idea ?

best regards,

-- 
Dr Emmanuel BETTLER
/-------------------------------/

CMBI
University of Nijmegen
P.O. Box 9010,
6500 GL Nijmegen, the Netherlands
http://www.cmbi.nl

Tel. +31 (0)24 36 53386
     +31 (0)24 36 53391 (CMBI's secretary)
Fax. +31 (0)24 36 52977 

Association 38Globule : http://www.globule38.net
Association AGM2 : http://assoagm2.free.fr
