Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUEBKLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUEBKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 06:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUEBKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 06:11:16 -0400
Received: from smtp-out7.xs4all.nl ([194.109.24.8]:24078 "EHLO
	smtp-out7.xs4all.nl") by vger.kernel.org with ESMTP id S262954AbUEBKLO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 06:11:14 -0400
Date: Sun, 2 May 2004 12:10:46 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Ian Stirling <linux-kernel@mauve.plus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debugging [binary] modules.
Message-ID: <20040502101046.GA5577@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <4093C5B8.5040806@mauve.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4093C5B8.5040806@mauve.plus.com>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Stirling <linux-kernel@mauve.plus.com>
Date: Sat, May 01, 2004 at 04:43:52PM +0100
> Is there any tool that logs every access of a module to anything?
> Every memory or IO access, all calls, ...
> Ideally without requiring any alterations to the module binary, for the
> case when source isn't available.

You should be looking at Bochs, I think.

Kind regards,
Jurriaan
-- 
>"Unsolicited commercial electronic mail can be an important mechanism
> through which businesses advertise and attract customers in the online
> environment." (HR 718)
"Mugging can be an important mechanism through which the economically
disadvantaged gain and maintain the ability to pay taxes."
	Reaction in news.admin.net-abuse.email by Alun Jones
Debian (Unstable) GNU/Linux 2.6.6-rc3-mm1 2x6062 bogomips 0.43 0.38
