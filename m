Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTLLSPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 13:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTLLSPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 13:15:37 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:42444 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261659AbTLLSPg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 13:15:36 -0500
Date: Fri, 12 Dec 2003 10:15:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Morris <jmorris@redhat.com>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       linux-kernel@vger.kernel.org
Subject: Re: sysctl vs /proc/sys
Message-ID: <20031212181517.GM15401@matchmail.com>
Mail-Followup-To: James Morris <jmorris@redhat.com>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
	linux-kernel@vger.kernel.org
References: <20031212.224649.20046672.yoshfuji@linux-ipv6.org> <Xine.LNX.4.44.0312120928120.2843-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Xine.LNX.4.44.0312120928120.2843-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 09:28:32AM -0500, James Morris wrote:
> On Fri, 12 Dec 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> 
> > Can we get the exact previous value from /proc/sys atomicly?
> 
> I'm not sure what you mean by this.

Read value and modify in one op?
