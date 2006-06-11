Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWFKSun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFKSun (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFKSun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:50:43 -0400
Received: from mail.enyo.de ([212.9.189.167]:58066 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750729AbWFKSum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:50:42 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
Date: Sun, 11 Jun 2006 20:50:37 +0200
In-Reply-To: <20060610222734.GZ27502@mea-ext.zmailer.org> (Matti Aarnio's
	message of "Sun, 11 Jun 2006 01:27:34 +0300")
Message-ID: <87ac8jsf0i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matti Aarnio:

> What will break ?
>
> You really should go and read SPF documents and guides and FAQs at:
>     http://spf.pobox.com/

The SPF specification is extremely loose, and it is hard to predict
for SPF record owners how their policy indications are interpreted.

For example, will you treat SoftFail, TempError and PermError as Fail?
