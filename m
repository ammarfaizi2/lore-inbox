Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbQL2HtU>; Fri, 29 Dec 2000 02:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQL2HtL>; Fri, 29 Dec 2000 02:49:11 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:8972 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129761AbQL2Hsx>;
	Fri, 29 Dec 2000 02:48:53 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops when mounting cdrom 
In-Reply-To: Your message of "Fri, 29 Dec 2000 01:55:51 BST."
             <3A4BE117.3F58333B@Hell.WH8.TU-Dresden.De> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Dec 2000 18:18:18 +1100
Message-ID: <16546.978074298@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000 01:55:51 +0100, 
"Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De> wrote:
>Can someone explain to me what all those ksymoops warnings are
>about?
>Warning (compare_maps): ksyms_base symbol acpi_clear_event_R__ver_acpi_clear_event not found in System.map.  Ignoring ksyms_base entry

Read the lkml FAQ, question 8.8.

cliche_generate(man, fish, teach).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
