Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTKDQGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTKDQGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:06:20 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:57476 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262319AbTKDQGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:06:20 -0500
Date: Tue, 4 Nov 2003 16:05:43 +0000
From: Dave Jones <davej@redhat.com>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend and AGP in 2.6.0-test9
Message-ID: <20031104160543.GD5512@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ruben Puettmann <ruben@puettmann.net>, linux-kernel@vger.kernel.org
References: <NMa8.7uR.11@gated-at.bofh.it> <NN6b.pY.5@gated-at.bofh.it> <E1AH3Rg-00033v-00@baloney.puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AH3Rg-00033v-00@baloney.puettmann.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 04:50:16PM +0100, Ruben Puettmann wrote:

 > > Suspend/Resume code in agpgart is virtually non-existant.
 > Do you know if there is some work in progress?

not afaik.

 > Without suspend and
 > resume with XFree most laptop users will not be happy with 2.6.

then most laptop users will need to wait until I've got time to
fix it, or fix it themselves.

		Dave

