Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbTCJV5P>; Mon, 10 Mar 2003 16:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCJV5O>; Mon, 10 Mar 2003 16:57:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S261851AbTCJV5N>;
	Mon, 10 Mar 2003 16:57:13 -0500
Date: Mon, 10 Mar 2003 16:07:43 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: Luben Tuikov <luben@splentec.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coding style addendum
Message-Id: <20030310160743.76ed3d67.reynolds@redhat.com>
In-Reply-To: <3E6D096A.1080006@splentec.com>
References: <Pine.LNX.3.95.1030310162308.14367A-100000@chaos>
	<3E6D096A.1080006@splentec.com>
Organization: Red Hat GLS
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss
 of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered Luben Tuikov <luben@splentec.com>, spoke thus:

>  References:
>  [1] ``The Elements of Programming Style'' by Kernighan
>  and Plauger, 2nd ed, 1988, McGraw-Hill.

Keep in  mind the date here.   Prior to this time,  subroutines were the
packaging  technique  of choice  to  promote  "software reuse":  i.  e.,
reference the _same_  code in various places throughout  a program.  K&P
were espousing a  fundamental shift in thinking by  using subroutines as
functional  abstractions.  Using  your  argument that  the example  code
hides an "implementation", it's difficult  to conceive of a code example
that hids neither its data nor its implementation.


I'd suggest an alternate tack:

        "When you are deep in the programming 'zone' and code is flowing
        from  your fingertips  and you  are  amazed at  the insight  and
        understanding evidenced by your code:

        STAND UP!  MOVE AWAY FROM THE KEYBOARD!  GO HOME!

        Look at the code again tomorrow and see if it makes any sense to
        you then."

