Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVCBOYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVCBOYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVCBOYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:24:38 -0500
Received: from web26604.mail.ukl.yahoo.com ([217.146.176.54]:30138 "HELO
	web26604.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262311AbVCBOYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:24:33 -0500
Message-ID: <20050302142433.12493.qmail@web26604.mail.ukl.yahoo.com>
Date: Wed, 2 Mar 2005 15:24:32 +0100 (CET)
From: BZ Benny <bennybbz@yahoo.fr>
Subject: Module Vs app?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an app wich run in the user space.
I want to create a virtual network device for catching
data under the IP layer and sending data to IP layer.
I want to creaate such a second eth0.

I know how we can do this with /linux/netdevice.h
but how can we do that from the user space?

regards
benny


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
