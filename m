Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVEEGNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVEEGNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 02:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVEEGNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 02:13:23 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:6236 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261907AbVEEGNU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 02:13:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Gymrq3Z3BjxDbQkP5jBI6H0GjQ2DlVoMqu0v5EOymtXfQEr5eRi+vdKlQkvGEA15+8ZTUdwiTnygt4ySNsWkm3VpOq06N1uEaACBKjt3oCijZM5oiq0YWWlu2HgVWxpFHdjko+ElaGKxSGe+/v/1IyzbeSsYRE5xMQIZxb3Ceho=
Message-ID: <3cac075b05050423135a8efa2@mail.gmail.com>
Date: Thu, 5 May 2005 11:13:20 +0500
From: Nauman <mailtonauman@gmail.com>
Reply-To: Nauman <mailtonauman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: EXT2-FS Error (ext2_new_block) Where is this comming from?? can anyone help
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear linux gurus, 
I have set up a Block Device over a SCSI drive. I write data to the
actual target drive after writing same blocks in my RAMDISK. I am
using RAMDISK of 2 GB. once the allcoated blocks of my RAMDISK are
full i start freeing those blocks (WRITE THROUGH). at  this point i
get this message during Write operations
Ext2 FS- Error: ext2_new_block : Allocating blocks in System zone. <block_nr>
Is this some sort of calculation error or some other configuration problem?? 

-- 
When the going gets tough, The tough gets going...!
Peace ,  
Nauman.
