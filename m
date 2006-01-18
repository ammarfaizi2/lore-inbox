Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWARAUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWARAUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWARAUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:20:49 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:37065 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964923AbWARAUs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:20:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=FlOBmeSzjRkdRLTDe36ePOaOH7sUFmXRzm/kGFI8IwPPVYnUXeT3IFqYPmF801t1lXivP7DxLLk3fiYQM3446uYFrAGTBU3w3QyJ1W+8wOiHP6uKk6n3x2dz4gT7glxt/PBhKPQD+I4XFxQmNLY9yIVWMbLUNlR2QJKHIE5AON4=
Date: Wed, 18 Jan 2006 01:20:29 +0100
From: Diego Calleja <diegocg@gmail.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
Message-Id: <20060118012029.db6bf538.diegocg@gmail.com>
In-Reply-To: <20060117141725.d80a1221.diegocg@gmail.com>
References: <20060116191556.bd3f551c.diegocg@gmail.com>
	<43CC7094.9040404@yahoo.com.au>
	<20060117141725.d80a1221.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 17 Jan 2006 14:17:25 +0100,
Diego Calleja <diegocg@gmail.com> escribió:

> > Can you apply the attached patch and try to reproduce the oops?
> 
> You're saying that I'll have to spend all the afternoon watching
> DVDs? Well, if the linux kernel needs it!


I've been running kaffeine for hours and i didn't triggered it, it's
hard to reproduce :/

I'll continue trying to hit it, even if it was a hardware error
it should happen again!
