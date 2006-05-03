Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWECA4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWECA4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWECA4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:56:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:23813 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965060AbWECA4q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:56:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V9EYpwlql/5YaCMD9XPQze1j+igPNUwM8lUCWY6Boe1nH4V0OjgRB5Y6xaR7rpCNGgjnhpiXzYntwaYh5g5NHAffR1aLxo+cM7k6Gvgc6tsC6dfA+zvY/EbxpYNQxTJTpYZAStwPP6VYoJ+wgBWOMflzdVTE1sz0KrM389hzCYo=
Message-ID: <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
Date: Tue, 2 May 2006 19:56:44 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Jared Hulbert" <jaredeh@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Jared Hulbert <jaredeh@gmail.com> wrote
>
> Why a new filesystem?
> - XIP of kernel is mainline, but not XIP of applications.  This
> enables application XIP

>From what I recall, XIP of the kernel off of MTD is limited to ARM.  I
assume AXFS suffers the same restriction?

josh
