Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161313AbWGJDI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbWGJDI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWGJDI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:08:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:22040 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161313AbWGJDI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:08:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCczO77z40Vs3ySgVgzf6X6bceoO3xKhs1f90GfzM9Yk8RKkiJNpYAKELWFo9Q+gmuK+v8FmmhLs+m2DTxb/HabAwyGZ/B8hPr8UNYtzNVmzNB6xAY/WrznNOf1ixCrogXqhCQlAPHRelKXogRevACobeRMdl3bsOB32TKg8VoQ=
Message-ID: <bda6d13a0607092008x7851cbe7t3cebdb8438722947@mail.gmail.com>
Date: Sun, 9 Jul 2006 20:08:55 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
In-Reply-To: <44B1A982.1060700@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
	 <44B1A982.1060700@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like the current keyboard code lets you press Alt-SysRq,
> Alt-<letter> without keeping the SysRq key held down, as long as you
> don't release the Alt key.
>
> That seems a lot more user-friendly to me.
>
>         -hpa

I second that. Using a non-modifier key (PrntScrn) as modifier is weird.
