Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283747AbRLEQCv>; Wed, 5 Dec 2001 11:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRLEQCl>; Wed, 5 Dec 2001 11:02:41 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:11499 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S283443AbRLEQCa>; Wed, 5 Dec 2001 11:02:30 -0500
Message-ID: <3C0E4487.6000704@savoirfairelinux.com>
Date: Wed, 05 Dec 2001 11:00:07 -0500
From: Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Removing an executable while it runs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I would like to remove an executable from the file-system while it is 
running and
get all the blocks back immediately, not after the end of the program.
Is this possible ?
 From what I understand, the inode is not released until the program 
ends. Do all the
file-systems behave the same way ?

Thank you for your help.


