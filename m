Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131691AbRDFPVP>; Fri, 6 Apr 2001 11:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131708AbRDFPVF>; Fri, 6 Apr 2001 11:21:05 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:5982 "EHLO
	nynetops04.e-steel.com") by vger.kernel.org with ESMTP
	id <S131691AbRDFPU7>; Fri, 6 Apr 2001 11:20:59 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: ethernet phy link state info
Date: 06 Apr 2001 11:20:10 -0400
Organization: e-STEEL Netops news server
Message-ID: <m3itkidphx.fsf@shookay.e-steel.com>
In-Reply-To: <41256A26.005733A6.00@elsa.de> <1d7601c0beab$0cb2bfa0$0a070d0a@axis.se>
NNTP-Posting-Host: shookay.e-steel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: nynetops04.e-steel.com 986570324 10068 192.168.3.43 (6 Apr 2001 15:18:44 GMT)
X-Complaints-To: news@nynetops04.e-steel.com
NNTP-Posting-Date: 6 Apr 2001 15:18:44 GMT
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try http://www.scyld.com/diag/

johan.adolfsson@axis.com ("Johan Adolfsson") writes:
> I don't have an answer but a related question:
> Is there any "standard ioctl" to force an interface
> to a certain link state, eg. auto, 10Mbs, 100Mbps,
> half/full duplex etc.?
> 
> If not, can we create a standard ioctl mechanism for it?
> 
> /Johan
> 
> ----- Original Message -----
> From: Bernhard Bender <Bernhard.Bender@ELSA.de>
> To: <linux-kernel@vger.kernel.org>
> Sent: Friday, April 06, 2001 16:54
> Subject: ethernet phy link state info
> 
> 
> >
> >
> > Hi all,
> >
> > where do I find information about the current link state of the ethernet
> PHY
> > (e.g. 100mbit/s full duplex) ?
> > Something like /proc/sys/net/* ?
> >
> > Thanks
> > Bernhard
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
