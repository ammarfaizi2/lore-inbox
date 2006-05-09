Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWEIWcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWEIWcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWEIWcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:32:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:44743 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751288AbWEIWcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:32:00 -0400
Date: Tue, 9 May 2006 15:30:22 -0700
From: Greg KH <greg@kroah.com>
To: Aaron Cohen <aaron@assonance.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB storage emulation
Message-ID: <20060509223022.GA21385@kroah.com>
References: <727e50150605090923k5796cbfcy99204c802a393573@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727e50150605090923k5796cbfcy99204c802a393573@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:23:41PM -0400, Aaron Cohen wrote:
> Is there any way currently to connect two computers via usb cable and
> have one of them pretend to be a usb storage device for the other?

Without special hardware, no.

With special hardware, yes.
