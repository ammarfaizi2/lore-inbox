Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280443AbRJaTtu>; Wed, 31 Oct 2001 14:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280449AbRJaTtl>; Wed, 31 Oct 2001 14:49:41 -0500
Received: from boreas.isi.edu ([128.9.160.161]:63951 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S280443AbRJaTth>;
	Wed, 31 Oct 2001 14:49:37 -0500
To: Rik van Riel <riel@conectiva.com.br>
cc: Timur Tabi <ttabi@interactivesi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Module Licensing? 
In-Reply-To: Your message of "Wed, 31 Oct 2001 15:10:13 -0200."
             <Pine.LNX.4.33L.0110311505160.2963-100000@imladris.surriel.com> 
Date: Wed, 31 Oct 2001 11:49:30 -0800
Message-ID: <3336.1004557770@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The fact that the open source portions and the closed source portions
>> can't function on their own is irrelevant, IMHO.
>>
>> Please show me where in the GPL text it says that the act of compiling a
>> module and loading it into memory is subject to the GPL.
>
>That'd be paragraph 2 b)
>
>    b) You must cause any work that you distribute or publish, that in
>    whole or in part contains or is derived from the Program or any
>    part thereof, to be licensed as a whole at no charge to all third
>    parties under the terms of this License.
>
>... These requirements apply to the modified work as a whole.
>
>Since your program, which happens to consist of one open
>source part and one proprietary part, is partly a derived
>work from the kernel source (by using kernel header files
>and the inline functions in it) your whole work must be
>distributed under the GPL.

	False.  Please cite the section of the GPL version 2 that you
think means that the derived work, once created, *must be
distributed*.  If you read closely, I think you will find that it says
that *if* you distribute the mixed work, then then it must be
distributed under the the terms of the GPL.  If you do *not*
distribute the mixed work, then the GPL does not place any
restrictions on your use of the derived work.  In other words, the
restrictions imposed by the GPL are conditional upon the derived
work's actual distribution:  no distribution, no restrictions.

	Furthermore, "loading into memory" is (arguably) considered an
essential part of running a program, and section 0 of the GPL version
2 says:

    The act of running the Program is not restricted,

	I should insert the usual disclaimer:  I am not a lawyer.

					Craig Milo Rogers
