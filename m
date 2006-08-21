Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWHUTVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWHUTVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWHUTVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:21:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:34889 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750839AbWHUTVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:21:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:content-transfer-encoding:from;
        b=nRUN5qYMJ+X+mIVLKmC4w6LLTRDoBdLimcV4aQGUNgJe8auKW2Jo7ah/fn6TYmIYV2GtlPDnEXU8nbHbNHoHZ7kit78GXl/+5lGCoe7ZqdZZRFOLM4Nljlh8Sd+r/elpQNN4NADSebOupx/vhBgwpWd2m1WBG6WQWi5QwADdqJ8=
Date: Mon, 21 Aug 2006 21:21:42 +0200
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-ID: <20060821192141.GA8978@gmail.com>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821081216.GA9194@gmail.com> <20060821113239.GA1919@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060821113239.GA1919@slug>
X-Operating-System: Linux 2.6.18-rc4-mm2
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 11:32:39AM +0000, Frederik Deweerdt wrote:
> On Mon, Aug 21, 2006 at 10:12:16AM +0200, Gregoire Favre wrote:
> > Hello,
> > 
> > like thunder7@xs4all.nl wrote :
> > "Also, it stil has the funny fast moving clock on x86-64"
> > As I already repported for 2.6.18.rc4-mm1 playing video too fast, I
> > suffer from the same problem.
> > 
> > I put under http://gregoire.favre.googlepages.com/linux all the config I
> > could think about in order to help find out where the problem came from.
> > 
> > I could add anything wanted, just CC to me as I am not under this ml.
> A patch is available in the hotfixes directory, have you tried it?

Tremendous : the patch solve my issue :-)

Thank you very much,
-- 
Grégoire FAVRE  http://gregoire.favre.googlepages.com  http://www.gnupg.org
