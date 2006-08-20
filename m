Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWHTOMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWHTOMw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWHTOMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 10:12:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:61577 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWHTOMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 10:12:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=ezuh5U/pcy9Lh6z0qpG3LRVY1l0mA1lkdjaetEpbX0cwga6aEeWsg42h0yPknixs+roiod9ZOFCR4bLTKv7j7SvaZP10iJmuegMmCojNEeGao+wQHvGqkpA6c4Bfsx1f6sjDW4XAmZaVd9WA4459igqltgK074uGlJ8zSy0xBEQ=
Date: Sun, 20 Aug 2006 18:12:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: =?iso-8859-1?Q?J=F8rn?= Amundsen <Jorn.Amundsen@ntnu.no>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-1.2174_FC5 oops
Message-ID: <20060820141240.GA5178@martell.zuzino.mipt.ru>
References: <Pine.GSO.4.58.0608201532230.22479@mysil.itea.ntnu.no> <6bffcb0e0608200701v32b45375o760b62ee20e6a714@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bffcb0e0608200701v32b45375o760b62ee20e6a714@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 04:01:20PM +0200, Michal Piotrowski wrote:
> On 20/08/06, Jørn Amundsen <Jorn.Amundsen@ntnu.no> wrote:
> >Dear Sirs, I got this oops when editing a file on a remote system,
> >logged in through ssh. Both screens suddenly turned black, and I found
> >the attached oops in /var/log/messages after pushing the reset button.
> >
> 
> Please fill bug report
> https://bugzilla.redhat.com/bugzilla/index.cgi

Which will be rejected there because of nvidia module.

