Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTJINqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTJINqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:46:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262034AbTJINqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:46:38 -0400
Date: Thu, 9 Oct 2003 09:45:57 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Tom Zanussi <zanussi@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <karim@opersys.com>, <bob@watson.ibm.com>
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
In-Reply-To: <16259.10547.72758.205812@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0310090943200.13537-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Tom Zanussi wrote:

> This 4-part patch contains code for an interim version of relayfs (see
> Documentation below for a description of relayfs).

What is wrong with using Netlink sockets instead of this?


- James
-- 
James Morris
<jmorris@redhat.com>


