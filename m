Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282501AbRKZUnC>; Mon, 26 Nov 2001 15:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282499AbRKZUmA>; Mon, 26 Nov 2001 15:42:00 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:23027 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S282500AbRKZUkJ>; Mon, 26 Nov 2001 15:40:09 -0500
From: junio@siamese.dhis.twinsun.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Weinehall <tao@acc.umu.se>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>
Date: 26 Nov 2001 12:39:34 -0800
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>
Message-ID: <7v1yil1d2x.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MT" == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

MT> On Mon, 26 Nov 2001, H. Peter Anvin wrote:
>> Consistency is a Very Good Thing[TM] (says the one who tries to teach
>> scripts to understand the naming.)  The advantage with the -rc naming is
>> that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
>> -pre-final-really-i-mean-it-this-time phenomenon when the release
>> candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
>> shame in needing more than one release candidate.

MT> Agreed. I stick with the -rc naming convention for 2.4+... 

(This is a request to maintainers of three stable trees).

While we are on the topic, could you also coordinate to keep the
EXTRAVERSION strings consistent?  2.4.X-preN uses "-preN" but
2.2.X-preN uses "preN" without leading "-".
