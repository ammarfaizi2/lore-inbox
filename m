Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVDWSSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVDWSSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDWSSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:18:08 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:37262 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261639AbVDWSSF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:18:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UonLmJJEFlOPynkFNoxpoxtn3/Gjk3GYzECRLJ/93HqakuIogy4k5uv0AQhQiS1V/HS1PqLzx737JaiGiZISh+mkWrILD5bF4AQB4zQGKKH4LEoji1zdv7zhM2uK+B9cSZ7WEnDm5ZVtXRpktT2BlM7J0/0k0sUIlVvqb2XooZQ=
Message-ID: <2a4f155d050423111874bac46b@mail.gmail.com>
Date: Sat, 23 Apr 2005 21:18:04 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc-4.0.0 final miscompiles net/ipv4/devinet.c:devinet_sysctl_register()
Cc: Mikael Pettersson <mikpe@csd.uu.se>, yoshfuji@linux-ipv6.org,
       jakub@redhat.com
In-Reply-To: <20050423175352.GU17420@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504230952.j3N9qm6W012596@harpo.it.uu.se>
	 <2a4f155d05042310375d99994b@mail.gmail.com>
	 <20050423175352.GU17420@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

ismail


On 4/23/05, Jakub Jelinek <jakub@redhat.com> wrote:
> On Sat, Apr 23, 2005 at 08:37:23PM +0300, ismail d?nmez wrote:
> > Whats the bugzilla # for this so others can track it?
> 
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21167
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21173
> 
> 	Jakub
> 

-- 
Time is what you make of it
