Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVDJNJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVDJNJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDJNJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:09:07 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:33767 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261492AbVDJNJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:09:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=och46b1B/jPiCLWiQeCJq0tTXs079TeX6YE5aYh70Uqohmtm0rGg8sgF6MHIGKYS8I9whaqS0JJTbTdPvutWvseV9wmXRUGWl3lRCLU6CgkckbQaIc8/USV4uggfFvE7SdpYpN3KkLdTbqxLwNUh5SKa6TrQHsEfhfNqpuWTkQ0=
Message-ID: <2a4f155d05041006096b203aed@mail.gmail.com>
Date: Sun, 10 Apr 2005 16:09:04 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Dennis Heuer <dh@triple-media.com>
Subject: Re: 2.6.11.x: bootprompt: ALSA: no soundcard detected
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1113128209l.588l.0l@Foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1113121569l.584l.0l@Foo>
	 <2a4f155d05041002022788ae8b@mail.gmail.com> <1113128209l.588l.0l@Foo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That means you didn't load the correct module for your soundcard.


On Sun, 10 Apr 2005 10:16:49 +0000, Dennis Heuer <dh@triple-media.com> wrote:
> This doesn't help. Alsamixer prints:
> 
> failure in snd_ctl_open: no such device
> 
> Dennis

-- 
Time is what you make of it
