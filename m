Return-Path: <linux-kernel-owner+w=401wt.eu-S1761258AbWLINsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761258AbWLINsK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761260AbWLINsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:48:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:55682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761258AbWLINsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:48:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=AbMh8mlqWUVfDDj94BP8syzu4+z2kDqNO3m1duIjkLla0GI37vTOorwM2VjI9e9XRdk/KOGaEl2hFxE47foLiUMYK3o4De/2UxoFA31GyM0tgJI0nI6b8SXi3JBxngU1pWdY9Y5Y+T63cvVYlRFkjJJ0jHQ0U9HrvGrXOK0e0qM=
Message-ID: <84144f020612090548r50a8ffaflb35ebbcd3e944e6a@mail.gmail.com>
Date: Sat, 9 Dec 2006 15:48:06 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: why are some of my patches being credited to other "authors"?
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
X-Google-Sender-Auth: 742b87987e9db105
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
>   perhaps i'm just being clueless about the authorship protocol here,
> but i'm a bit hacked off by noticing that at least one submitted patch
> of mine was apparently re-submitted (albeit slightly modified) a few
> days later by another poster and applied under that poster's name.
>
>   on sun, dec 3, i submitted to the list:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116516635728664&w=2

It really seems to be Burman Yan's patch from November 22. Notice how
your patch still has the redundant cast whereas the applied one
doesn't.
