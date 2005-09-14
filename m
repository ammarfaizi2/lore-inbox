Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVINJfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVINJfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVINJfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:35:14 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:28605 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965115AbVINJfM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:35:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FbVPsos0diF+4pydaBrVeXB9bg36X85nczRlDv3/AfScxJvalnlBkZf8gjKI+eBP5kKm/QZ3Kjr/g/MrHRWu+bQpqzesjDTcu+f+jC8eUrN6Q1hyVfsQmD+g8rn9K3UIrwQovw8+FdL+1nV88SV1A/L/2sGYwQw8kEaIYduPw6w=
Message-ID: <2cd57c90050914023512213c1f@mail.gmail.com>
Date: Wed, 14 Sep 2005 17:35:11 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: suggest mm-commits subjects
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2cd57c9005091402337fee047d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cd57c9005091402337fee047d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> Hi,
> 
> I'd like to suggest mm-commits subjects in these forms:
> 
> [added] foo.patch added to -mm tree
> [removed] foo.patch removed from -mm tree
> 
> or
> 
> [A] foo.patch added to -mm tree
> [R] foo.patch removed from -mm tree

or

[+] foo.patch added to -mm tree
[-] foo.patch removed from -mm tree

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
