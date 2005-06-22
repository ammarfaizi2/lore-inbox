Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVFVDSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVFVDSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVFVDSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:18:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262551AbVFVDSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:18:35 -0400
Date: Tue, 21 Jun 2005 23:18:24 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Lorenzo HernXndez GarcXa-Hierro <lorenzo@gnu.org>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@tycho.nsa.gov>
Subject: Re: [patch 1/2] selinux: add executable stack check
In-Reply-To: <20050622015156.AAD7056C876@estila.tuxedo-es.org>
Message-ID: <Xine.LNX.4.44.0506212317540.4511-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Lorenzo HernXndez GarcXa-Hierro wrote:

> kernel-execstack.patch adds such permission to the SELinux code within
> the kernel and adds the proper permission check to the selinux_file_mprotect() hook.
> 
> Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>

Acked-by: James Morris <jmorris@redhat.com>


-- 
James Morris
<jmorris@redhat.com>


