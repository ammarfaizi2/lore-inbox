Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWGFQlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWGFQlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWGFQlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:41:09 -0400
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:30094 "HELO
	web25806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965109AbWGFQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:41:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=S+vSasONZaA41tpCkskCcz/KNdnV4VAWZLNO9DM/5PwS3GTmj0HZX3u1caAP/sOYSzwJ/FlLyC4lyub9RF3Dz/TeU7TKoZfoObGkrf0OLDl9yZGsf9tUieEg43peiEfZIa0zTxyVpzEscMm4wYqTc8tjg0k2tA8DmPYTYnh765I=  ;
Message-ID: <20060706164107.89250.qmail@web25806.mail.ukl.yahoo.com>
Date: Thu, 6 Jul 2006 16:41:07 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: __pa() versus virt_to_phys()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could anybody tell me the difference between these two symbols ?

I know that one is a macro and the other one is an inline function,
so the latter performs type checkings but I don't see anything else.

thanks

Francis


