Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbUJ0GgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbUJ0GgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbUJ0Gc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:32:29 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:54646 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262289AbUJ0GcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:32:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm1
Date: Wed, 27 Oct 2004 01:31:52 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, vojtech@suse.cz
References: <20041026213156.682f35ca.akpm@osdl.org> <200410270042.34224.dtor_core@ameritech.net> <20041026225135.7ca1eb58.akpm@osdl.org>
In-Reply-To: <20041026225135.7ca1eb58.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410270131.52475.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 12:51 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> >  Please consider applying the patch below for parkbd instead of
> >  Rusty's changes.
> 
> Please just put it in your bk tree and that'll toss out Rusty's bits.
> 

Done. Vojtech, please pull when you have a moment.

-- 
Dmitry
