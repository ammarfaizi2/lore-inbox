Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317266AbSFRB7w>; Mon, 17 Jun 2002 21:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317268AbSFRB7v>; Mon, 17 Jun 2002 21:59:51 -0400
Received: from catbert.mcs.anl.gov ([140.221.8.87]:58240 "EHLO
	catbert.mcs.anl.gov") by vger.kernel.org with ESMTP
	id <S317266AbSFRB7u>; Mon, 17 Jun 2002 21:59:50 -0400
To: linux-kernel@vger.kernel.org
Subject: bizarre segv problem on 2.5.22
From: "Narayan Desai" <desai@mcs.anl.gov>
Date: Mon, 17 Jun 2002 20:59:47 -0500
Message-ID: <yrxvg8h5oto.fsf@catbert.mcs.anl.gov>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having an odd problem under 2.5.22. python2 run from inside of an
rpm rebuild call dies with a sevfault, while everything works properly
with a 2.4.18. Does anyone have any idea what is going on?
thanks...
 -nld
