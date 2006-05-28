Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWE1J3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWE1J3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 05:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWE1J3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 05:29:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:7215 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932095AbWE1J3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 05:29:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=a9OHURg1wT6LrIFDZcsBH6CR+N4avHAeXfRvlkYOQN2ZgJXT/do5ehZ4hK0tm+zj5hnh8sJrIlgh6DY+SMDkHBjswHS6cwOo7bs4WoZGOVniKAL/R6uTaTxlJS40n0HG+T/bbrC8dnT8JV83mTbxTzenuzoD7Npgs3WeIhPiE1Q=
Message-ID: <35fb2e590605280229g76e75419h10717238e15e7347@mail.gmail.com>
Date: Sun, 28 May 2006 10:29:12 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [ANNOUNCE] Linux Device Driver Kit available
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060524232900.GA18408@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060524232900.GA18408@kroah.com>
X-Google-Sender-Auth: bc92b874f28670cc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/06, Greg KH <greg@kroah.com> wrote:

> It is a cd image that contains everything that a Linux device driver
> author would need in order to create Linux drivers, including a full
> copy of the O'Reilly book, "Linux Device Drivers, third edition" and
> pre-built copies of all of the in-kernel docbook documentation for easy
> browsing.  It even has a copy of the Linux source code that you can
> directly build external kernel modules against.

Thanks Greg. I'll download a copy and take a look.

Random ideas:

* Bootable Damn Small Linux (DSL) or similar.
* cached LXR (obviously with reduced function).

Jon.
