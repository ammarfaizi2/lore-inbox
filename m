Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbSJJRWD>; Thu, 10 Oct 2002 13:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261710AbSJJRWD>; Thu, 10 Oct 2002 13:22:03 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:48648 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261708AbSJJRWD>; Thu, 10 Oct 2002 13:22:03 -0400
Date: Thu, 10 Oct 2002 18:27:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Grothe <dave@gcom.com>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com,
       bidulock@openss7.org
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Message-ID: <20021010182740.A23908@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Grothe <dave@gcom.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	linux-kernel@vger.kernel.org,
	LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com,
	bidulock@openss7.org
References: <4386E3211F1@vcnet.vc.cvut.cz> <5.1.0.14.2.20021010115616.04a0de70@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20021010115616.04a0de70@localhost>; from dave@gcom.com on Thu, Oct 10, 2002 at 11:57:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a) please read Documentation/CodingStyle
b) please add a prototype in a header
c) please make it EXPORT_SYMBOL_GPL

