Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbUL3HMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUL3HMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUL3HMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:12:19 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:40214 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261553AbUL3HMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:12:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=O8CTNxYZ1FS1gS1zJv7CIjzKnrZn1G/gcYzdrGMZfNvDoT6eJicUET9o0dB4ZpdlFoUUm0bqjVrenejaaYTImdYyJkZ59bzq584aPKCZq7ivguw+XGkBJdQGJp3JK7EPeBDOO7LSiowpd1SE2LhP8cmFx1GYna9yR29a8jYsW9A=
Message-ID: <4d8e3fd304122923127167067c@mail.gmail.com>
Date: Thu, 30 Dec 2004 08:12:16 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Trying out SCHED_BATCH
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
In-Reply-To: <41D33603.9060501@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <m3mzw262cu.fsf@rajsekar.pc> <41CD51E6.1070105@kolivas.org>
	 <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak> <41D31373.1090801@kolivas.org>
	 <4d8e3fd304122914466b42c632@mail.gmail.com>
	 <41D33603.9060501@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 09:56:03 +1100, Con Kolivas <kernel@kolivas.org> wrote:
> Paolo Ciarrocchi wrote:
> > Are you gointo  to push to Linus/Andrew ?
> 
> Staircase? I'm still in pain from the last time I tried to push it in a
> more palatable form via the plugsched architecture which took me a long
> time to do. I don't have the fortitude to go through that again in a hurry.

Yup, I remember your tentative.

Andrew, 
what's your plan for the staircase scheduler ?

-- 
Paolo
