Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVFUMqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVFUMqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFUMqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:46:09 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:23637 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261320AbVFUMnx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:43:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=khzaByh/UTgtgjkRkPSW9lYPmAfCx0R49j21wzLkWX1bUSuOvYB3+WX8RejS8IsBNsOOTWcfe6N4AtEzh0i70YmArbixxqpR2jGPHcHiLqGjluwJhb9ocabN8lpcp1GpFW3Z4Mwm2eNbeMUUFG+QFKOvXnsrgm/kiv9e3WWbZQ4=
Message-ID: <5c77e707050621054320fa9f37@mail.gmail.com>
Date: Tue, 21 Jun 2005 14:43:49 +0200
From: Carsten Otte <cotte.de@gmail.com>
Reply-To: Carsten Otte <cotte.de@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -mm -> 2.6.13 merge status
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> execute-in-place
> 
>     Will merge.  Have the embedded guys commented on the usefulness of
>     this for execute-out-of-ROM?
Allright. Going to push our test-team to run their tests on the xip
code that is in -mm.
