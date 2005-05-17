Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVEQN0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVEQN0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVEQN0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:26:14 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:44628 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261505AbVEQN0L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:26:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DxIBhSYocLhUCgzyvalCDfn2JLqaUyQ+YFIQrCHYdhScieBIkyNhq4ZWl6+MB9cLwuxhCqNXbI01mNwi5I2fm8/JtmuKdcqSMLUQPou3gvZEerbnEPzcaqSj5FmHPAUhnBbjTsu4/46GjXKPovvDPrdbwPLSP5nATUx1sVNzh8w=
Message-ID: <4ad99e0505051706265ea06f7@mail.gmail.com>
Date: Tue, 17 May 2005 15:26:09 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/8] dlm: overview
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
In-Reply-To: <20050517001133.64d50d8c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050516071949.GE7094@redhat.com>
	 <20050517001133.64d50d8c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Andrew Morton <akpm@osdl.org> wrote:
> The usual fallback is to identify all the stakeholders and get them to say
> "yes Andrew, this code is cool and we can use it", but I don't think the
> clustering teams have sufficent act-togetherness to be able to do that.

It is highly unlikely that this will ever happen because of the
different nature of these projects. That said getting a kernel system
for dlm and message passing should be doable given the wide variety
off uses they have.
