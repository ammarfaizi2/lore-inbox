Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbQKAUXM>; Wed, 1 Nov 2000 15:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130804AbQKAUXC>; Wed, 1 Nov 2000 15:23:02 -0500
Received: from dm3cnd.bell.ca ([198.235.69.146]:51724 "HELO dm3cnd.bell.ca")
	by vger.kernel.org with SMTP id <S130348AbQKAUWn>;
	Wed, 1 Nov 2000 15:22:43 -0500
X-Server-Uuid: b85f21a3-cfd1-11d3-8401-00104bf46ab7
Message-ID: <3A007B8A.CFF19318@bell.ca>
Date: Wed, 01 Nov 2000 15:22:34 -0500
From: "Jean-Francois Patenaude" <jf.patenaude@bell.ca>
Organization: Bell Canada
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Tigran Aivazian" <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel panic while copying files
In-Reply-To: <Pine.LNX.4.21.0011012012580.5182-100000@saturn.homenet>
X-WSS-ID: 161EA4073214-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I'll get back with the oops information ASAP !




Tigran Aivazian wrote:
> 
> Jean-Francois,
> 
> You are reporting a panic but missing the most important ingredient:
> 
> On Wed, 1 Nov 2000, Jean-Francois Patenaude wrote:
> > [5.] Output of Oops.. message (if applicable) with symbolic information
> >      resolved (see Documentation/oops-tracing.txt)
> >
> > xx
> >
> 
> If "xx" means "kiss-kiss" then you can "kiss good bye" to any hope of
> resolving this panic until you send the oops message passed through
> ksymoops. If this is really a panic and not an oops then you need to
> capture it through a serial console and then pass through ksymoops on the
> next boot.
> 
> Regards,
> Tigran

-- 
/\/\/\/\/\/\/\/
Jean-Francois Patenaude
MGR EXPERT. CTRE CLIENTS SERV. / DIR. CTRE EXP. SERVICE CLIENTS
700 DE LA GAUCHETIERE OUEST  RC-MEZ  MONTREAL (QUEBEC)  H3B 4L1
Tel: (514) 870-3190   Fax: (514) 391-8660   Pag: (514) 330-4479
/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/  jf.patenaude@bell.ca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
