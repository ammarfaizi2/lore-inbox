Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWEGUhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWEGUhg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 16:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWEGUhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 16:37:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:8604 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932222AbWEGUhf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 16:37:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nnoserUFcDQM5Yd/cdqs/xV42BG5VcJLaUoNmcRXlQrAbn+5tocdaMxEAMmDXDewtStQH39sEksdE0eps4aUsbwQnk/UxdRkOIltK/MpsLxa+7OW1aJvY2nuCw28A/aPWG2ck7hhF0L4lrSwj63etLl74pctSd02cjQsp1ajlgE=
Message-ID: <9a8748490605071337v21faa94fm58b864354642e43@mail.gmail.com>
Date: Sun, 7 May 2006 22:37:34 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andries.Brouwer@cwi.nl" <Andries.Brouwer@cwi.nl>
Subject: Re: a Linux swap storm
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605071931.k47JVbs18224@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605071931.k47JVbs18224@apps.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/06, Andries.Brouwer@cwi.nl <Andries.Brouwer@cwi.nl> wrote:
[snip]
> At this moment the machine became unusable for twenty minutes
[snip]
> The machine is vanilla 2.6.14, 256MB, 550MB swap.
[snip]
> The effect is reproducible.
>
[snip]

Reproducible - nice.
Have you tried it with a newer kernel like 2.6.16.14 or
2.6.17-rc3-git13 ?  Could be interresting to see if it has already
been fixed since 2.6.14... in any case, it's one more datapoint :-)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
