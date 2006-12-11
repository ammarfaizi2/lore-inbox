Return-Path: <linux-kernel-owner+w=401wt.eu-S1762893AbWLKNGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762893AbWLKNGw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762897AbWLKNGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:06:52 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:58608 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762893AbWLKNGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:06:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aqDKwlrEkPh0W452QVCWPq9DXgUtbuSukcgoX6E4yCRUflqHqJbT8HbCozskslhDew1pr6zkdPRSkloTPZxNfVj+7HFzvC/Q9GEyO7rTyHZj0jSDgFphxBn3SfR9jQk678dKH5U8sznkmOnvsqxkzbLYcx1nmsFzPMepP3mjwNc=
Message-ID: <9a8748490612110506t3e529e3ta04f5a89f78b6e01@mail.gmail.com>
Date: Mon, 11 Dec 2006 14:06:50 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "kalyan kumar" <rkklinux@gmail.com>
Subject: Re: kernel compilation on windows XP using cygwin
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <995e96530612110447q45528d5foa9eff1f400ebad6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <995e96530612110447q45528d5foa9eff1f400ebad6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/06, kalyan kumar <rkklinux@gmail.com> wrote:
> I am not able to compile latest kernel code in cygwin environment. It
> fails for not ELF error always and exits. Any suggestions please?
>

One suggestion:  Don't do that.
That's not a supported way to build the kernel.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
