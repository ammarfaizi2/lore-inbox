Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265382AbUADXBl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUADXBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:01:41 -0500
Received: from main.gmane.org ([80.91.224.249]:57814 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265382AbUADXBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:01:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Any hope for HPT372/HPT374 IDE controller?
Date: Mon, 05 Jan 2004 00:01:36 +0100
Message-ID: <yw1xad5348tr.fsf@ford.guide>
References: <S265365AbUADWL5/20040104221159Z+4976@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:vmVF9lS62Rj2ZIlLzqo8LoSbTm8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tomwallard@soon.com writes:

> Many people seem to have problems with the Highpoint HPT372 and HPT374 IDE
> controllers. Several months ago there was a thread in which many people
> reported failure and not many people reported success. For example, "hdX:
> lost interrupt" errors right before a crash are a common problem. This was
> happening over a wide range of kernel versions. In my case it happens more
> quickly if there is heavy network or video load at the same time as heavy
> load on this controller. (This is a motherboard with a KT400 chipset).
>
> Have any recent improvements been made? Does anyone have one of
> these controllers actually working correctly? Does anyone have any
> idea where to begin tracking this problem down?

Mine is working wonderfully.  Linux 2.4.22 and 2.6.0 both work with a
HTP374 based RocketRAID 1540 SATA card in an Alpha SX164.  Would
anyone like more details about the system?

-- 
Måns Rullgård
mru@kth.se

