Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVHKKEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVHKKEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVHKKEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:04:12 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:26901 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964853AbVHKKEL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:04:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UN0bg7gB3p+4fPKtWLVnyjhWlf3EuDvNvpjrPi85L6oRWHyKFu+WEXDH9HDpTDVgODExnDwge7sVu/unsUhnXoE5FEHBM3HWeQOa42wYlZzgX+h/7aa42AuZSa0LI3lYq55If7YUEiUHa8xLyehpDAiqKSGasINeP0P8yEckSEQ=
Message-ID: <84144f0205081103043067d36e@mail.gmail.com>
Date: Thu, 11 Aug 2005 13:04:10 +0300
From: Pekka Enberg <penberg@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: GFS - updated patches
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20050811091651.GB19972@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050802071828.GA11217@redhat.com>
	 <20050811081729.GB12438@redhat.com>
	 <1123749159.3201.19.camel@laptopd505.fenrus.org>
	 <20050811085006.GA19972@redhat.com>
	 <1123750232.3201.22.camel@laptopd505.fenrus.org>
	 <20050811091651.GB19972@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/05, David Teigland <teigland@redhat.com> wrote:
> The large majority, and I think all that people care about.  If we ignored
> something that someone thinks is important, a reminder would be useful.

The only remaining issue for me is the vma walk. Thanks, David!

                                 Pekka
