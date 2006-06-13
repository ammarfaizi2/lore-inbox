Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWFMWan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWFMWan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWFMWam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:30:42 -0400
Received: from smtp-out.google.com ([216.239.45.12]:39314 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932324AbWFMWal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:30:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=oNsGBoZACre37JS6XxPvY+vg2cF8V4yXqJ9/SSeghDTU6W7iApdL+irVzltLJfm3n
	WAGMNKGqN3sriB+X9xuKQ==
Message-ID: <448F3C83.9080606@google.com>
Date: Tue, 13 Jun 2006 15:30:27 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: "Brian F. G. Bidulock" <bidulock@openss7.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> can you name some non-GPL non-proprietary modules we should be concerned
> about?

You probably meant "non-GPL-compatible non-proprietary".  If so, then by
definition there are none.

Regards,

Daniel
