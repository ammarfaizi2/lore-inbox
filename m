Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSJPTBf>; Wed, 16 Oct 2002 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSJPTBf>; Wed, 16 Oct 2002 15:01:35 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:54795 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261324AbSJPTBe>;
	Wed, 16 Oct 2002 15:01:34 -0400
Date: Wed, 16 Oct 2002 12:07:24 -0700
From: Greg KH <greg@kroah.com>
To: netdev@oss.sgi.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] change format of LSM hooks
Message-ID: <20021016190724.GB25475@kroah.com>
References: <20021015194545.GC15864@kroah.com> <20021015.124502.130514745.davem@redhat.com> <20021015201209.GE15864@kroah.com> <20021015.131037.96602290.davem@redhat.com> <20021015202828.GG15864@kroah.com> <20021016000706.GI16966@kroah.com> <20021016081539.GF20421@kroah.com> <20021016185927.GA25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016185927.GA25475@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 11:59:28AM -0700, Greg KH wrote:
> 
> Ok, here's a working version (I'm typing from it right now), with all of
> the capability logic working again.  This does make the
> security/built-in.o file this size with CONFIG_SECURITY=y
> 
>    text    data     bss     dec     hex filename
>    1611       0       0    1611     64b security/built-in.o

That should have said CONFIG_SECURITY=n

Sorry for any confusion.

greg k-h
