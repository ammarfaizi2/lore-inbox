Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUJWPq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUJWPq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 11:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUJWPq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 11:46:28 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:45294 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261204AbUJWPqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 11:46:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=d0YMxeLN4+erBqEmi2Ihcqx9JXc2QBClLMw77VV8obihUxey85bUt3wIV4nW6jmot7HrdHplzq8mGy78PnZidCPqA2iQc0+mZOJEiGv1EVfwul672CzBofPLsp7pRSABw+q3GqQIl2mn02FQAKLakeuuK9VKomu3jAIWlYW+bvA=
Message-ID: <5afb2c65041023084647891227@mail.gmail.com>
Date: Sat, 23 Oct 2004 13:46:24 -0200
From: Fabiano Ramos <fabiano.ramos@gmail.com>
Reply-To: Fabiano Ramos <fabiano.ramos@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: little help about FIX_STACK on debug entry
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

   Can anynone give me some light on the FIX_STACK issue on
debug entry?

TIA,
Fabiano
