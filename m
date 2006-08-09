Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWHIWRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWHIWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWHIWRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:17:16 -0400
Received: from outbound2.mail.tds.net ([216.170.230.92]:16022 "EHLO
	outbound2.mail.tds.net") by vger.kernel.org with ESMTP
	id S1751328AbWHIWRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:17:15 -0400
Subject: Re: Upgrading kernel across multiple machines
From: David Lloyd <dmlloyd@flurg.com>
To: Brian McGrew <brian@visionpro.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <C0FFAB00.89A2%brian@visionpro.com>
References: <C0FFAB00.89A2%brian@visionpro.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:18:12 -0500
Message-Id: <1155161892.24896.0.camel@ultros>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 15:08 -0700, Brian McGrew wrote:
> It would appear that way; but I assure you, the modules are in
> /lib/modules/2.6.16.16/

Maybe you forgot to copy over your initrd image?

- DML

