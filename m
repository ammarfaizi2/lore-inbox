Return-Path: <linux-kernel-owner+w=401wt.eu-S964894AbXAJOoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbXAJOoX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 09:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbXAJOoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 09:44:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:4738 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964894AbXAJOoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 09:44:22 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fTQfrwB5RbMBr/WPdlgYjB2UfCKwfRHLtZAcUJBz+6K7SIzygPvZTc44H+4r5tEwYdwFS2+/tnbpL1LlDbsznFTeaCSUiYKL3z4dofx5WB3x+CIYgfYVB7kI7637q1HoFHeGmp0ON9W3VaAPujr2BjGIyEqsrhH2NXNtN5m6onc=
Message-ID: <84144f020701100644u483cf60y239608b0174161f4@mail.gmail.com>
Date: Wed, 10 Jan 2007 16:44:20 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [PATCH] slab: cache_grow cleanup
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hugh@veritas.com
In-Reply-To: <Pine.LNX.4.64.0701091017350.15631@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701091539160.10824@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0701091017350.15631@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: 2e606dc75e7cadc8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/07, Christoph Lameter <clameter@sgi.com> wrote:
> I am loosing track of these. What is the difference to earlier versions?

It is just a rediff on top of Linus' tree as Hugh's fix already went in.

                                  Pekka
