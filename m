Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVISPfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVISPfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 11:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVISPfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 11:35:39 -0400
Received: from web35915.mail.mud.yahoo.com ([66.163.179.199]:37766 "HELO
	web35915.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932467AbVISPfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 11:35:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SCJ/xoW3EfBiMRzmbgBRBIc+aH42suz6TpmitMIuDxOq/PIyHonU+MQcgbCtJA+tH8gqnYpeHZBR0aKAbNShV+pLOub5CbYi4YvUTovlLbY7/O+weIkJ+zauCLVOpyS1B6O92fp81Z+VxSkjSxKSPwyliAt5MTBfW1wQoLqAvU0=  ;
Message-ID: <20050919153534.75405.qmail@web35915.mail.mud.yahoo.com>
Date: Mon, 19 Sep 2005 08:35:33 -0700 (PDT)
From: umesh chandak <chandak_pict@yahoo.com>
Subject: adding  new lsm hooks
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,

In wireless network ,most of the attacks occurs at mac
layer .so i think ,we should detect this attack at mac
layer itself.so I think we can add lsm hooks at mac
layer
in linux for wireless networks.so i want to add new
hooks in it  . therefore i want to know the procedure
of adding new hooks,which file should i change,which
functions should i write and like that .Hooks may be
of any type for time being .
                help me out.
                                        bye
  


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
