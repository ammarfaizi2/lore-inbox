Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWBIJ51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWBIJ51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBIJ51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:57:27 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:9690 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1030624AbWBIJ50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:57:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=nQcp11IVQTieuAfhCauAQPno3rz5rdjTRLjiXj5ybb7qmtngLc6UG++oXglompgL6Vqe+rIDc0bC98cPDuFJX8QOj8hwQdl0BBVNnSkQb6/HDlJBrmTwxY2vN/Rsnl6RzTfpe9GZmgnfZbFqGIgMGzaAgHHNq8sEZKXSLVcBICU=;
Date: Thu, 9 Feb 2006 12:55:09 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kirill Korotaev <dev@sw.ru>,
       Kirill Korotaev <dev@openvz.org>, arjan@infradead.org,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
Message-ID: <20060209095509.GA5747@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru> <m1irrpsifp.fsf@ebiederm.dsl.xmission.com> <20060208235348.GC26035@ms2.inr.ac.ru> <m11wyd5pv8.fsf@ebiederm.dsl.xmission.com> <20060209011126.GB5417@ms2.inr.ac.ru> <20060209025135.GA29197@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209025135.GA29197@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> do you mean "preserving some sort of *global* pidspace"?

Of course.

Alexey
