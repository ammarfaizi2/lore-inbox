Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265460AbRFVQ2M>; Fri, 22 Jun 2001 12:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265462AbRFVQ2C>; Fri, 22 Jun 2001 12:28:02 -0400
Received: from t2.redhat.com ([199.183.24.243]:31982 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265460AbRFVQ1x>; Fri, 22 Jun 2001 12:27:53 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010622111154.A13799@thyrsus.com> 
In-Reply-To: <20010622111154.A13799@thyrsus.com>  <20010622094934.A13075@thyrsus.com> <20010621160309.A6744@thyrsus.com> <20010621154934.A6582@thyrsus.com> <20010621205537.X18978@flint.arm.linux.org.uk> <20010621160309.A6744@thyrsus.com> <7987.993197604@redhat.com> <20010622094934.A13075@thyrsus.com> <10604.993218210@redhat.com> <20010622102458.A13435@thyrsus.com> <18157.993221693@redhat.com> 
To: esr@thyrsus.com
Cc: Russell King <rmk@arm.linux.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Jun 2001 17:27:46 +0100
Message-ID: <28493.993227266@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  Alas, my report generators aren't smart enough to know that.  The
> CML1  config syntax makes it hard to extract that kind of information,
> and  I haven't worked at it because the CML2 cutover looks like
> happening fairly soon.  When I know there's an exception case, I put
> it on my  ignore list.

OK. You didn't put these two on your ignore list the first time I told you
about them. Can I assume, then, that you've done so now and you won't be
asking about them again for a while?

I'll resend the patch which removes the unused VIRTUAL_ER config option if 
Linus hasn't applied it when 2.4.6 proper comes out.

--
dwmw2


