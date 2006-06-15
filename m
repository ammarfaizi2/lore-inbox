Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbWFOOyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbWFOOyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbWFOOyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:54:36 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:60806 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1030560AbWFOOyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:54:35 -0400
From: Janne Karhunen <Janne.Karhunen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NFSv3 client reordering RENAMEs
Date: Thu, 15 Jun 2006 17:54:33 +0300
User-Agent: KMail/1.9.3
References: <200606151638.15792.Janne.Karhunen@gmail.com> <4491644E.8000506@redhat.com>
In-Reply-To: <4491644E.8000506@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606151754.33384.Janne.Karhunen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2006 16:44, Peter Staubach wrote:

> >really expect RENAME to be reordered as mv is generally considered
> >atomic. That, and RFC 1813 mandates RENAME to be atomic. Is this a
> >known thing and do you guys consider this feature or a bug?
>
> Can you construct a testcase which exhibits this behavior?

Possibly .. if someone first acks that this indeed would be
considered as bug and not as a feature :/ 


-- 
// Janne
