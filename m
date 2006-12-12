Return-Path: <linux-kernel-owner+w=401wt.eu-S932286AbWLLRkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWLLRkk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWLLRkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:40:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52551 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbWLLRkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:40:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p4JkcEyzUoHNRGrT4Z3hjNXCfvmXXZK0WG5yxLNZI9YfNNMcbzNi36dmokhcKITwPyZtPhqZF34H5YTc0Sf3fnUxfVBkNIveajycE9R0jjMkE+ZY9kHLmnVk0rWEY0odE292NMaHl3g8DNIup7J9a1XW/21gN59cQcE/+koaQ20=
Message-ID: <d120d5000612120940s16f26b27p4b9e0792038693b6@mail.gmail.com>
Date: Tue, 12 Dec 2006 12:40:35 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Cal Peake" <cp@absolutedigital.net>, "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [PATCH] Note subscribers only lists for input subsystem
Cc: trivial@kernel.org, "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612121157110.4219@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612121157110.4219@lancer.cnet.absolutedigital.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Cal Peake <cp@absolutedigital.net> wrote:
> According to Dmitry in <http://lkml.org/lkml/2006/10/17/280>, the input
> list is subscribers only. I'm assuming here that both are but a
> confirmation would be nice... :)
>
> From: Cal Peake <cp@absolutedigital.net>
>
> Annotate the MAINTAINERS file to reflect the subscribers only nature of
> the input mailing lists.
>

Actually I'd rather have them open, let's see if Vojtech could change
that... The main problem is that not only input lists accept posts
from subscribers only but they silently drop everything else. Maybe
dropping only HTML posts would be a decent compromise.

-- 
Dmitry
