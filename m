Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265258AbSJRNC6>; Fri, 18 Oct 2002 09:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265260AbSJRNC5>; Fri, 18 Oct 2002 09:02:57 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:10252 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265258AbSJRNC5>; Fri, 18 Oct 2002 09:02:57 -0400
Date: Fri, 18 Oct 2002 14:08:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: "David S. Miller" <davem@redhat.com>, greg@kroah.com, hch@infradead.org,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018140854.D1670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>,
	"David S. Miller" <davem@redhat.com>, greg@kroah.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021017203652.GB592@kroah.com> <20021017.133816.82029797.davem@redhat.com> <20021017205830.GD592@kroah.com> <20021017.135832.54206778.davem@redhat.com> <3DAFBFA2.4040207@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAFBFA2.4040207@wirex.com>; from crispin@wirex.com on Fri, Oct 18, 2002 at 01:00:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 01:00:34AM -0700, Crispin Cowan wrote:
> If you remove this system call, you will save almost nothing in kernel 
> resources, but do a lot of damage to functionality.

But I remove an extensible, very broken interface before it's too late.

