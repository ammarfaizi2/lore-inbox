Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUGIR73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUGIR73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 13:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUGIR73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 13:59:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265139AbUGIR71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 13:59:27 -0400
Date: Fri, 9 Jul 2004 13:59:25 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Thomas DuBuisson <tomd@csds.uidaho.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Crypto] twofish-flag.patch
In-Reply-To: <Pine.LNX.4.53.0407091006040.11273@scooter.csds.uidaho.edu>
Message-ID: <Xine.LNX.4.44.0407091359140.4895-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004, Thomas DuBuisson wrote:

> Unless there is a good reason for the flag handling to be different in 
> twofish than in AES or Serpent I think this needs applied.  It just sets 
> the proper flag if someone tries to run twofish_setkey with an improper 
> key size.

This looks fine to me.


- James
-- 
James Morris
<jmorris@redhat.com>


