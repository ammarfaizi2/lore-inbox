Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVARPro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVARPro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVARPrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:47:06 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:62860 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261330AbVARPmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:42:19 -0500
Date: Tue, 18 Jan 2005 16:42:16 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118154216.GL2839@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	"Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
	linux-kernel@vger.kernel.org
References: <2E314DE03538984BA5634F12115B3A4E01BC42B5@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC42B5@email1.mitretek.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 10:07:27AM -0500, Piszcz, Justin Michael wrote:
> Not trying to spread FUD, I am just explaining I had the same issue and
> that was the resolution.

Well, *if* the reason of your issue was the same as the reason of
my issue (what could be, but must not be), you were in the lucky
position that after unclipping your drive your partition's size
was a multiple of 1024 *and* (2048|4096) while before it wasn't.
Chances of that are about 1:(1|3) - not that bad at all :)


Mario
-- 
It is practically impossible to teach good programming style to students
that have had prior exposure to BASIC: as potential programmers they are
mentally mutilated beyond hope of regeneration.  -- Dijkstra
