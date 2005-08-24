Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbVHXGJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbVHXGJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVHXGJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:09:30 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:55457 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751461AbVHXGJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:09:30 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=f26GTc6rHkfDIITIc7uflmoe2Hl8WLtiWGTnqcjrT9BAVBC77FPqOiJIm/+Nge64E
	sK7nSlc9oEyRKWojS8zuA==
Date: Tue, 23 Aug 2005 23:09:27 -0700
From: David Brownell <david-b@pacbell.net>
To: ytht.net@gmail.com
Subject: Re: [PATCH 2.6.12.5]error condition fix in usbnet
Cc: linux-kernel@vger.kernel.org
References: <20050824041300.GA5139@gsy2.lepton.home>
In-Reply-To: <20050824041300.GA5139@gsy2.lepton.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050824060927.960C345341@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You noticed that too, eh?  It's already fixed in the patches
I may yet send out tonight, splitting "usbnet" and its
minidrivers into separate files ...

- Dave

