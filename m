Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTAJSR4>; Fri, 10 Jan 2003 13:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbTAJSR4>; Fri, 10 Jan 2003 13:17:56 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22065 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S265242AbTAJSRv>; Fri, 10 Jan 2003 13:17:51 -0500
Subject: [PATCH] oprofile backport to 2.4.20
From: graydon hoare <graydon@redhat.com>
To: marcelo tosatti <vane@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>,
       oprofile-list <oprofile-list@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Jan 2003 13:25:42 -0500
Message-Id: <1042223143.4329.435.camel@dub.venge.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

oprofile entered the 2.5 series after some discussion and design changes
from its initial form. will cohen and myself have backported the 2.5
driver to 2.4.20, and intend to maintain it in a nearly-synchronized
state with the 2.5 driver, for future 2.4 releases. this driver shipped
with our recent phoebe beta. the patch is located at:

http://people.redhat.com/graydon/linux-2.4.20-oprofile-public-1.patch

future updates will appear in my directory there. we are interested in
any feedback, and also curious as to the possibility of integrating some
or all of this patch into marcelo's 2.4 tree.

direct followups appreciated; I am not subscribed to lkml.

-graydon

