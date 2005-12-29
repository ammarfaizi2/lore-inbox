Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVL2WYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVL2WYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVL2WYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:24:48 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:20528 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751054AbVL2WYr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:24:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N2ikK+fYZoGVZ8WSzSX4YXrLfc6TbKpatFDY/78gnjdxPk9OW5+UNI3dAFDZ0varg5/jlZB2xn/tqNJnvBfhHZsJaOzQa4hIkjJj96Ct+cILZFuXzhqacKAs9N3asiViidgzF1RgFtFNbpQbY5y45JKXorbKvbaC++M23QNPnK4=
Message-ID: <9a8748490512291424r302d77e5pc70ba5e08ad5dec7@mail.gmail.com>
Date: Thu, 29 Dec 2005 23:24:46 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Trilight <trilight@ns666.com>
Subject: Re: 2.6.14.5 / swapping / killing random apps
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B40635.4030002@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B3DC7A.7010000@ns666.com>
	 <9a8748490512290616y34cae1aav776035e8b650264@mail.gmail.com>
	 <43B40635.4030002@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, Trilight <trilight@ns666.com> wrote:
<!-- snip -->
>
> I just did bad block check and it turns out to be good.
>
> If there is anything else i can check i'm all ears hehe
>
Have you checked you log files/dmesg for clues after an occourance of
the problem?
Have you checked the logs for interresting messages leading up to the problem?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
