Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWEUTiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWEUTiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWEUTiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:38:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2946 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964932AbWEUTiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:38:51 -0400
Date: Sun, 21 May 2006 15:38:41 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Ulrich Drepper <drepper@gmail.com>, dragoran <dragoran@feuerpokemon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521193841.GH8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, Ulrich Drepper <drepper@gmail.com>,
	dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org> <20060521160332.GA8250@redhat.com> <a36005b50605211135v2d55827fr96360d9a025b9db8@mail.gmail.com> <20060521193542.GA1594@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521193542.GA1594@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 12:35:42PM -0700, Chris Wedgwood wrote:
 > On Sun, May 21, 2006 at 11:35:12AM -0700, Ulrich Drepper wrote:
 > 
 > > It's not a glibc problem really.  The problem is this stupid error
 > > message in the kernel.
 > 
 > It must have been added very recently surely?  Has this syscall
 > implemented and the FC kernel doesn't seem that old.

It was added in 2.6.17rc

		Dave

-- 
http://www.codemonkey.org.uk
